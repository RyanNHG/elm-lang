module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { thing : Maybe String
    }


type Msg
    = DoNothing


links : List ( String, String )
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


type alias Markdown =
    String


type alias SectionContent =
    { title : String
    , content : Markdown
    }



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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
