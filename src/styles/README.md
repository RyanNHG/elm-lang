# styles | elm-lang
> Someone please teach me Elm CSS.


### Simple Overview

Every class is either a:

1. __Block__ - An independent piece of UI.
1. __Element__ - A subset of a block.
1. __Modifier__ - A modification of a block or element.

What that means is there are only a few valid patterns:

__Pattern__ | __Example__
--- | ---
`B` | `nav`
`B__E` | `nav__title`
`B--M` | `nav--dark`
`B__E--M` | `nav__title--lowercase`

As you can see, every class must start with a "block".

That makes it easy to find the file you are looking for.

So if you see this out in the wild:

```elm
viewNavbar =
    div [ class "nav nav--dark" ]
        [ a [ class "link link--bigger" ] [ text "elm" ]
        , a [ class "link" ] [ text "learn" ]
        , a [ class "link" ] [ text "community" ]
        ]
```

You can reliable find the code for each class by looking at it's `block`.

Once you have the `block` name, just find the `block` in the `blocks` folder:

__`blocks/_nav.scss`__
```scss
.nav {

  // Styles for `.nav`

  &--dark {
    // Styles for `.nav--dark`
  }

}
```

__`blocks/_link.scss`__
```scss
.link {

  // Styles for `.link`

  &--bigger {
    // Styles for `.link--bigger`
  }

}
```

Every `block` has it's own file, and all the styles are namespaced so you can't get rekt.

Oh yea, and there's a bunch of variables in the `variables/` folder.

They follow similar rules. If you see this in a `block`:

```scss
.button {

    color: $colors__dark-blue;
    font-size: $fonts__button;

}
```

You can reliably trace the variable prefix to the file that has the variable:

__`variables/_colors.scss`__
```scss
// ...
$colors__dark-blue: #34495e;
// ...
```
__`variables/_fonts.scss`__
```scss
// ...
$fonts__button: 16px;
// ...
```

I do it, because I _love_ you. Have fun coding, pal.