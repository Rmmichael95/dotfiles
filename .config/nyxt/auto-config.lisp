(DEFINE-CONFIGURATION BUFFER
  ((DEFAULT-MODES (APPEND '(NYXT::VI-NORMAL-MODE) %SLOT-DEFAULT%))))
(DEFINE-CONFIGURATION PROMPT-BUFFER
  ((DEFAULT-MODES (APPEND '(NYXT::VI-INSERT-MODE) %SLOT-DEFAULT%))))
(DEFINE-CONFIGURATION WEB-BUFFER
  ((DEFAULT-NEW-BUFFER-URL "search.brave.com")))
(defvar *my-search-engines*
  (list
   '("DuckDuckGo" "https://duckduckgo.com/")
   '("Brave" "http://search.brave.com")

