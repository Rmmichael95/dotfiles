<?php
class Bootstrap_Navwalker extends Walker_Nav_Menu {

    // Start level (Dropdown menu container)
    function start_lvl( &$output, $depth = 0, $args = null ) {
        $indent = str_repeat("\t", $depth);
        $submenu_class = $depth > 0 ? ' dropdown-menu-submenu' : '';
        $output .= "\n$indent<ul class=\"dropdown-menu$submenu_class\" aria-labelledby=\"navbarDropdown\">\n";
    }

    // Start element (Individual menu item)
    function start_el( &$output, $item, $depth = 0, $args = null, $id = 0 ) {
        $indent = ( $depth ) ? str_repeat("\t", $depth) : '';

        $classes = empty( $item->classes ) ? array() : (array) $item->classes;
        $classes[] = 'nav-item';

        // Check if the item has children and add 'dropdown' class for parent items
        if ( $args->walker->has_children ) {
            $classes[] = 'dropdown';
        }

        // Check if the item is the current menu item or an ancestor
        if ( in_array('current-menu-item', $classes) || in_array('current-menu-ancestor', $classes) ) {
            $classes[] = 'active';
        }

        $class_names = join( ' ', apply_filters( 'nav_menu_css_class', array_filter( $classes ), $item, $args ) );
        $class_names = $class_names ? ' class="' . esc_attr( $class_names ) . '"' : '';

        $id = apply_filters( 'nav_menu_item_id', 'menu-item-'. $item->ID, $item, $args );
        $id = $id ? ' id="' . esc_attr( $id ) . '"' : '';

        $output .= $indent . '<li' . $id . $class_names .'>';

        $atts = array();
        $atts['title']  = ! empty( $item->attr_title ) ? $item->attr_title : '';
        $atts['target'] = ! empty( $item->target )     ? $item->target     : '';
        $atts['rel']    = ! empty( $item->xfn )        ? $item->xfn        : '';
        $atts['href']   = ! empty( $item->url )        ? $item->url        : '';

        // Determine class based on depth (nav-link for parents, dropdown-item for dropdown items)
        if ( $args->walker->has_children ) {
            $atts['class']        = 'nav-link dropdown-toggle';
            $atts['data-bs-toggle'] = 'dropdown';
            $atts['aria-expanded'] = 'false';
            $atts['role']         = 'button';
        } else {
            // Use "dropdown-item" for items in dropdowns, otherwise "nav-link"
            $atts['class'] = $depth === 0 ? 'nav-link' : 'dropdown-item';
        }

        // Add "active" class to <a> if current menu item
        if ( in_array('current-menu-item', $classes) || in_array('current-menu-ancestor', $classes) ) {
            $atts['class'] .= ' active';
        }

        $atts = apply_filters( 'nav_menu_link_attributes', $atts, $item, $args );

        $attributes = '';
        foreach ( $atts as $attr => $value ) {
            if ( ! empty( $value ) ) {
                $value = ( 'href' === $attr ) ? esc_url( $value ) : esc_attr( $value );
                $attributes .= ' ' . $attr . '="' . $value . '"';
            }
        }

        $item_output = $args->before;
        $item_output .= '<a'. $attributes .'>';
        $item_output .= $args->link_before . apply_filters( 'the_title', $item->title, $item->ID ) . $args->link_after;
        $item_output .= '</a>';
        $item_output .= $args->after;

        $output .= apply_filters( 'walker_nav_menu_start_el', $item_output, $item, $depth, $args );
    }

    // End element
    function end_el( &$output, $item, $depth = 0, $args = null ) {
        $output .= "</li>\n";
    }
}
