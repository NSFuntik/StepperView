//
//  TermsConditionsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
import MarkdownUI

var markdownView: some View = Markdown(TsCsMarkdown)
var style = MarkdownStyle(font: .system(size: 13, weight: .regular, design: .rounded), foregroundColor: .infoBlue, measurements: .init())

struct TermsConditionsView: View {
    @State var termsAccepted: Bool = false
    @State var actorType: ActorsEnum
    @State var showingAlert: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ZStack {
                HStack {
                    DottedLine()
                        .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                        .shadow(radius: 0.5)
                        .frame(width: UIScreen.main.bounds.width / 2 - 5, height: 0.5, alignment: .leading)
                        .ignoresSafeArea(.all, edges: .leading)
                        .foregroundColor(Color.lightGray)
                    Spacer()
                }
                Image("VerifyStep")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30, alignment: .center)
            }.frame(height: 50, alignment: .center).padding(.bottom, -10)

            HStack {
                ScrollView {
                    //                    Text(TsCsMarkdown)
//                    Text(TsCsMarkdown))
                    markdownView
                        .pinchToZoom()
                        .multilineTextAlignment(.leading)
                        .markdownStyle(style)
                }
                Spacer()
            }
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
            }
            HStack(alignment: .center, spacing: 15) {
                Image(systemName: termsAccepted ? "checkmark.square.fill" : "square")
                    .foregroundColor(termsAccepted ? Color.accentColor : Color.lightGray)
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .onTapGesture {
                        termsAccepted.toggle()
                    }
                Text("Agree with terms and conditions")
                    .foregroundColor(.secondary).lineLimit(1)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
            NavigationLink(destination: EnrolledProfileView(actorType: actorType)) {
                HStack {
                    Text("Accept").withDoneButtonStyles(backColor: termsAccepted ? Color("AccentColor") : Color.white,
                                                        accentColor: termsAccepted ? Color.white : Color.lightGray)
                }.padding(.bottom, 20)
            }.opacity(termsAccepted ? 1.0 : 0.0).transition(.opacity).animation(.easeInOut(duration: 0.5), value: termsAccepted)
        }
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationTitle("Terms & Conditions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TermsConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TermsConditionsView(actorType: .PROVIDER)
        }
    }
}

let termsText =
    """
    ---
    __Advertisement :)__

    - __[pica](https://nodeca.github.io/pica/demo/)__ - high quality and fast image
      resize in browser.
    - __[babelfish](https://github.com/nodeca/babelfish/)__ - developer friendly
      i18n with plurals support and easy syntax.

    You will like those projects!

    ---

    # h1 Heading 8-)
    ## h2 Heading
    ### h3 Heading
    #### h4 Heading
    ##### h5 Heading
    ###### h6 Heading


    ## Horizontal Rules

    ___

    ---

    ***


    ## Typographic replacements

    Enable typographer option to see result.

    (c) (C) (r) (R) (tm) (TM) (p) (P) +-

    test.. test... test..... test?..... test!....

    !!!!!! ???? ,,  -- ---

    "Smartypants, double quotes" and 'single quotes'


    ## Emphasis

    **This is bold text**

    __This is bold text__

    *This is italic text*

    _This is italic text_

    ~~Strikethrough~~


    ## Blockquotes


    > Blockquotes can also be nested...
    >> ...by using additional greater-than signs right next to each other...
    > > > ...or with spaces between arrows.


    ## Lists

    Unordered

    + Create a list by starting a line with `+`, `-`, or `*`
    + Sub-lists are made by indenting 2 spaces:
      - Marker character change forces new list start:
        * Ac tristique libero volutpat at
        + Facilisis in pretium nisl aliquet
        - Nulla volutpat aliquam velit
    + Very easy!

    Ordered

    1. Lorem ipsum dolor sit amet
    2. Consectetur adipiscing elit
    3. Integer molestie lorem at massa


    1. You can use sequential numbers...
    1. ...or keep all the numbers as `1.`

    Start numbering with offset:

    57. foo
    1. bar


    ## Code

    Inline `code`

    Indented code

        // Some comments
        line 1 of code
        line 2 of code
        line 3 of code


    Block code "fences"

    ```
    Sample text here...
    ```

    Syntax highlighting

    ``` js
    var foo = function (bar) {
      return bar++;
    };

    console.log(foo(5));
    ```

    ## Tables

    | Option | Description |
    | ------ | ----------- |
    | data   | path to data files to supply the data that will be passed into templates. |
    | engine | engine to be used for processing templates. Handlebars is the default. |
    | ext    | extension to be used for dest files. |

    Right aligned columns

    | Option | Description |
    | ------:| -----------:|
    | data   | path to data files to supply the data that will be passed into templates. |
    | engine | engine to be used for processing templates. Handlebars is the default. |
    | ext    | extension to be used for dest files. |


    ## Links

    [link text](http://dev.nodeca.com)

    [link with title](http://nodeca.github.io/pica/demo/ "title text!")

    Autoconverted link https://github.com/nodeca/pica (enable linkify to see)


    ## Images

    ![Minion](https://octodex.github.com/images/minion.png)
    ![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

    Like links, Images also have a footnote style syntax

    ![Alt text][id]

    With a reference later in the document defining the URL location:

    [id]: https://octodex.github.com/images/dojocat.jpg  "The Dojocat"


    ## Plugins

    The killer feature of `markdown-it` is very effective support of
    [syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).


    ### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

    > Classic markup: :wink: :crush: :cry: :tear: :laughing: :yum:
    >
    > Shortcuts (emoticons): :-) :-( 8-) ;)

    see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.


    ### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

    - 19^th^
    - H~2~O


    ### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)

    Footnote 1 link[^first].

    Footnote 2 link[^second].

    Inline footnote^[Text of inline footnote] definition.

    Duplicated footnote reference[^second].

    [^first]: Footnote **can have markup**

        and multiple paragraphs.

    [^second]: Footnote text.


    ### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)

    Term 1

    :   Definition 1
    with lazy continuation.

    Term 2 with *inline markup*

    :   Definition 2

            { some code, part of Definition 2 }

        Third paragraph of definition 2.

    _Compact style:_

    Term 1
      ~ Definition 1

    Term 2
      ~ Definition 2a
      ~ Definition 2b


    ### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

    This is HTML abbreviation example.

    It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

    *[HTML]: Hyper Text Markup Language

    ### [Custom containers](https://github.com/markdown-it/markdown-it-container)

    ::: warning
    *here be dragons*
    :::

    """
