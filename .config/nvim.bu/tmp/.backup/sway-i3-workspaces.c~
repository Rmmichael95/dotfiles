#define SWAY_WORKSPACES
#include "sbtheme.h"
#include <ujson.h>
#include <unistd.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>

enum ipc_command_type {
    IPC_COMMAND = 0,
    IPC_GET_WORKSPACES = 1,
    IPC_SUBSCRIBE = 2,
    IPC_GET_OUTPUTS = 3,
    IPC_GET_TREE = 4,
    IPC_GET_MARKS = 5,
    IPC_GET_BAR_CONFIG = 6,
    IPC_GET_VERSION = 7,
    IPC_GET_BINDING_MODES = 8,
    IPC_GET_CONFIG = 9,
    IPC_SEND_TICK = 10,
    IPC_SYNC = 11,
    IPC_GET_BINDING_STATE = 12,
    IPC_GET_INPUTS = 100,
    IPC_GET_SEATS = 101,
    IPC_EVENT_WORKSPACE = ((1<<31) | 0),
    IPC_EVENT_OUTPUT = ((1<<31) | 1),
    IPC_EVENT_MODE = ((1<<31) | 2),
    IPC_EVENT_WINDOW = ((1<<31) | 3),
    IPC_EVENT_BARCONFIG_UPDATE = ((1<<31) | 4),
    IPC_EVENT_BINDING = ((1<<31) | 5),
    IPC_EVENT_SHUTDOWN = ((1<<31) | 6),
    IPC_EVENT_TICK = ((1<<31) | 7),
    IPC_EVENT_BAR_STATE_UPDATE = ((1<<31) | 20),
    IPC_EVENT_INPUT = ((1<<31) | 21),
};

static int sockfd;
static char *bar_output;
static int block_button;
static int subblock;
static int focused;

struct workspace {
    char *text;
    unsigned int urgent;
};

static struct workspace *workspaces = 0;
static int workspace_count = 0;

static int ipc_xfer(uint32_t type, const char *payload, uint32_t len, char **resp)
{
    static const char magic [6] = "i3-ipc";
    static const char *array_key = "\"workspaces\":";
    static const int header_size = sizeof(magic) + 8;

    char tx_header [header_size], rx_header [header_size];
    size_t rx;
    uint32_t resp_len, rx_len;
    uint32_t rx_type;

    memcpy(tx_header, magic, sizeof(magic));
    memcpy(tx_header + sizeof(magic), &len, sizeof(len));
    memcpy(tx_header + sizeof(magic) + sizeof(len), &type, sizeof(type));

    if (write(sockfd, tx_header, sizeof(tx_header)) == -1) {
        perror("write ipc header");
        return -1;
    }

    if (write(sockfd, payload, len) == -1) {
        perror("write ipc payload");
        return -1;
    }

    rx = 0;
    while (rx < header_size) {
        ssize_t rlen = recv(sockfd, rx_header + rx,
                header_size - rx, 0);
        if (rlen <= 0) {
            perror("recv icp header");
            return -1;
        }
        rx += rlen;
    }

    memcpy(&rx_len, rx_header + sizeof(magic), sizeof(rx_len));
    memcpy(&rx_type, rx_header + sizeof(magic), sizeof(rx_type));

    resp_len = rx_len + strlen(array_key) + 3;

    *resp = malloc(resp_len);

    (*resp)[0] = '{';
    strcpy(*resp + 1, array_key);

    rx = 0;
    while (rx < rx_len) {
        ssize_t rlen = recv(sockfd, *resp + rx + strlen(array_key) + 1,
                rx_len - rx, 0);
        if (rlen <= 0) {
            perror("recv icp payload");
            return -1;
        }
        rx += rlen;
    }

    (*resp)[resp_len - 2] = '}';
    (*resp)[resp_len - 1] = 0;

    return rx_len;
}

static void cleanup_workspaces()
{
    if (workspaces) {
        for (int i = 0; i < workspace_count; i++) {
            free(workspaces[i].text);
        }
        free(workspaces);
        workspaces = 0;
        workspace_count = 0;
    }
}

static int read_workspaces()
{
    JsonObject *jo;
    JsonArray *ws_array;
    JsonError err;
    char *resp = 0;
    int ret = 0;

    cleanup_workspaces();

    if (ipc_xfer(IPC_GET_WORKSPACES, "", 0, &resp) < 0) {
        if (resp) {
            free(resp);
        }
        return 1;
    }

    jsonErrorInit(&err);
    jo = jsonParseString(resp, &err);
    free(resp);

    if (!jo || jsonErrorIsSet(&err)) {
        ret = 1;
        goto end;
    }

    jsonGetArray(jo, "workspaces", &ws_array, &err);
    if (jsonErrorIsSet(&err)) {
        ret = 1;
        goto end;
    }

    for (int i = 0; i < ws_array->used; i++) {
        char *tmp, *output;
        struct workspace *workspace;
        unsigned int ws_focused;

        JsonObject *ws = ws_array->vals[i];
        if (jsonErrorIsSet(&err)) {
            ret = 1;
            goto end;
        }

        jsonGetString(ws, "output", &output, &err);
        if (jsonErrorIsSet(&err)) {
            ret = 1;
            goto end;
        }

        if (strcmp(output, bar_output) != 0) {
            continue;
        }

        workspaces = realloc(workspaces,
                sizeof(struct workspace) * ++workspace_count);

        workspace = &workspaces[workspace_count - 1];

        jsonGetBool(ws, "focused", &ws_focused, 1, &err);
        if (jsonErrorIsSet(&err)) {
            ret = 1;
            goto end;
        }

        if (ws_focused) {
            focused = workspace_count - 1;
        }

        jsonGetBool(ws, "urgent", &workspace->urgent, 1, &err);
        if (jsonErrorIsSet(&err)) {
            ret = 1;
            goto end;
        }

        jsonGetString(ws, "name", &tmp, &err);
        if (jsonErrorIsSet(&err)) {
            ret = 1;
            goto end;
        }

        workspace->text = strdup(tmp);
    }

end:

    if (jsonErrorIsSet(&err)) {
        jsonErrorCleanup(&err);
    }

    if (jo) {
        jsonCleanup(jo);
    }

    return ret;
}

static int open_socket(const char *path)
{
    struct sockaddr_un addr;

    if ((sockfd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
        perror("socket");
        return 1;
    }
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
    addr.sun_path[sizeof(addr.sun_path) - 1] = 0;

    if (connect(sockfd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
        perror("connect");
        return 1;
    }

    return 0;
}

static void cleanup()
{
    cleanup_workspaces();
    close(sockfd);
}

static void goto_workspace(char *name)
{
    char msg [BUFSIZ], *resp = 0;
    snprintf(msg, sizeof(msg), "workspace %s", name);
    msg[sizeof(msg) - 1] = 0;
    ipc_xfer(IPC_COMMAND, msg, strlen(msg), &resp);

    if (resp) {
        free(resp);
    }
}

#define getintenv(out, name)\
{ \
    char *str = getenv(name); \
    if (str) { \
        out = atoi(str); \
    } \
}
int main(int argc, char *argv[])
{
    int ret = 0;

    char *sock_path = getenv("SWAYSOCK");
    if (!sock_path) {
        sock_path = getenv("I3SOCK");
    }
    bar_output = getenv("BAR_OUTPUT");
    getintenv(block_button, "BLOCK_BUTTON");
    getintenv(subblock, "SUBBLOCK");

    if (!sock_path) {
        fprintf(stderr, "SWAYSOCK/I3SOCK not set\n");
        return 1;
    }

    if (!bar_output) {
        fprintf(stderr, "BAR_OUTPUT not set\n");
        return 1;
    }

    if (open_socket(sock_path)) {
        return 1;
    }

    if (read_workspaces()) {
        ret = 1;
        goto cleanup;
    }

    if (block_button == 1) {
        if (workspace_count <= subblock) {
            goto cleanup;
        }
        focused = subblock;
        goto_workspace(workspaces[focused].text);
    } else if (block_button == 4) {
        if (focused == 0) {
            focused = workspace_count - 1;
        } else {
            focused--;
        }
        goto_workspace(workspaces[focused].text);
    } else if (block_button == 5) {
        if (focused == workspace_count - 1) {
            focused = 0;
        } else {
            focused++;
        }
        goto_workspace(workspaces[focused].text);
    }

    if (block_button != 0) {
        if (read_workspaces()) {
            ret = 1;
            goto cleanup;
        }
    }

    printf("{\"subblocks\":[");

    for (int i = 0; i < workspace_count; i++) {
        struct workspace *ws = &workspaces[i];

        if (i != 0) {
            printf(",");
        }

        printf("{");
        printf("\"text\":\"%s\",", ws->text);

        for (int n = 0; n < sizeof(properties) / sizeof(struct Property); n++) {
            struct Property p = properties[n];
            printf("\"%s\":%s,", p.key, p.str);
        }

        #define STR2(x) #x
        #define STR(x) STR2(x)

        if (focused == i) {
            printf("\"background\":\"" STR(focusedcolor) "\"");
        } else if (ws->urgent) {
            printf("\"background\":\"" STR(urgentcolor) "\"");
        } else {
            printf("\"background\":\"" STR(unfocusedcolor) "\"");
        }
        printf("}");
    }
    printf("]}\n");

cleanup:
    cleanup();

    return ret;
}
