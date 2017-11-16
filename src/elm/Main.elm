module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown


type alias Model =
    { thing : Maybe String
    }


type Msg
    = DoNothing


type alias Link =
    ( String, String )


links : List Link
links =
    [ ( "learn", "/learn" )
    , ( "community", "/community" )
    , ( "packages", "/packages" )
    , ( "blog", "/blog" )
    ]


type alias HeroContent =
    { title : String
    , subtitle : String
    }


hero : HeroContent
hero =
    HeroContent "elm" "A delightful language for reliable webapps."


type alias Section =
    { title : String
    , content : SectionContent
    }


type SectionContent
    = Markdown String
    | Quote QuoteContent
    | TileList (List TileContent)
    | Multiple (List SectionContent)


type alias TileContent =
    { title : String
    , link : String
    , imageUrl : String
    }


type alias QuoteContent =
    { quote : String
    , author : String
    , link : Link
    , image : Image
    }


type alias Image =
    { url : String
    , altText : String
    }


homepageSections : List Section
homepageSections =
    [ Section "features" <|
        Markdown """

### Javascript Interop

Elm compiles to JavaScript, so trying out Elm is easy. Convert a small part of your app to Elm and
[embed it in JS](/blog/how-to-use-elm-at-work) . No full rewrites, no huge time investment. More about that
[here](http://guide.elm-lang.org/interop/).


### No Runtime Exceptions

Unlike hand-written JavaScript, Elm code does not produce runtime exceptions in practice. Instead,
Elm uses type inference to detect problems during compilation and give [friendly hints](/blog/compilers-as-assistants)
. This way problems never make it to your users. NoRedInk has 80k+ lines of Elm, and after more than a year
in production, it still has not produced a single runtime exception.


### Great Performance

Elm has its own virtual DOM implementation, designed for simplicity and speed. All values are immutable in Elm, and
[the benchmarks](/blog/blazing-fast-html-round-two) show that this helps us generate particularly fast JavaScript code.


### Enforced Semantic Versioning

Elm can detect all API changes automatically thanks to its type system. We use that information to force everything in
[our package catalog](http://package.elm-lang.org) to follow [semantic versioning](https://github.com/elm-lang/elm-package/#version-rules)
precisely. No more surprises in PATCH releases!

    """
    , Section "examples" <|
        Multiple
            [ Markdown """
Learning by example is important, so we have some [simple](http://elm-lang.org/examples) and
[elaborate](http://builtwithelm.co/) examples to help you as you move through [An Introduction to Elm](http://guide.elm-lang.org/).
Here are some nice ones!
            """
            , TileList
                [ TileContent "todomvc" "https://evancz.github.io/elm-todomvc" "http://elm-lang.org/assets/examples/todomvc.png"
                , TileContent "hedley" "https://gizra.github.io/elm-hedley" "http://elm-lang.org/assets/examples/hedley.png"
                , TileContent "conduit" "http://rtfeldman.github.io/elm-spa-example/" "http://elm-lang.org/assets/examples/elm-spa-example.png"
                , TileContent "package.elm-lang.org" "http://package.elm-lang.org/" "http://elm-lang.org/assets/examples/package.png"
                ]
            ]

    --, Section "users" <| Multiple []
    ]



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model Nothing, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            model ! []



--- VIEW


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ viewNavigation
        , viewHero
        , viewSections
        , viewFooter
        ]


viewNavigation : Html Msg
viewNavigation =
    nav [ class "nav app__slidable--up" ]
        [ div [ class "nav__container container" ]
            [ a [ class "nav__brand", href "/" ]
                [ img [ class "nav__brand-image", alt "Elm logo", src "/images/logo.png" ] [] ]
            , div [ class "nav__links" ] (List.map viewNavLink links)
            ]
        ]


viewNavLink : ( String, String ) -> Html Msg
viewNavLink ( label_, link ) =
    a [ class "nav__link link", href link ] [ text label_ ]


viewHero : Html Msg
viewHero =
    section [ class "hero" ]
        [ div [ class "container app__fadable" ]
            [ h1 [ class "hero__title" ] [ text hero.title ]
            , h2 [ class "hero__subtitle" ] [ text hero.subtitle ]
            ]
        ]


viewSections : Html Msg
viewSections =
    div [ class "section__container container app__fadable app__fadable--delayed" ]
        (List.map viewSection homepageSections)


viewSection : Section -> Html Msg
viewSection { title, content } =
    section [ class "section" ]
        [ h3 [ class "section__title" ] [ text title ]
        , viewSectionContent content
        ]


viewSectionContent : SectionContent -> Html Msg
viewSectionContent content =
    case content of
        Markdown markdown ->
            Markdown.toHtml [ class "section__content rich-text" ] markdown

        Quote quote ->
            viewQuote quote

        TileList list ->
            viewTiles list

        Multiple list ->
            div [ class "section__multiple" ] (List.map viewSectionContent list)


viewQuote : QuoteContent -> Html Msg
viewQuote quote =
    div [ class "quote" ] [ text "TODO: Quote section" ]


viewTiles : List TileContent -> Html Msg
viewTiles tiles =
    div [ class "tile__list" ]
        (List.map viewTileContent tiles)


viewTileContent : TileContent -> Html Msg
viewTileContent { title, link, imageUrl } =
    a [ class "tile", href link, target "_blank" ]
        [ div
            [ class "tile__image-container" ]
            [ img [ class "tile__image", src imageUrl, alt title ] [] ]
        , div
            [ class "tile__details" ]
            [ h4 [ class "tile__title" ] [ text title ]
            ]
        ]


viewFooter : Html Msg
viewFooter =
    footer [ class "footer" ]
        [ div [ class "footer__text container" ]
            [ text "All code for this site is open source and written in Elm!" ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
