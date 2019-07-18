module Css = BlogPageStyles;

[@react.component]
let make = () => {
  <Page>
    <div className=Css.blog>
      <div> "Blog"->React.string </div>
      <div>
        {Posts.all
         ->Array.map(post =>
             <div key={post.slug}>
               <ReactRouter.Link path={Route.post(~slug=post.slug)}>
                 post.title->React.string
               </ReactRouter.Link>
             </div>
           )
         ->React.array}
      </div>
      <div>
        <ReactRouter.Link path="/"> "To Main"->React.string </ReactRouter.Link>
      </div>
    </div>
  </Page>;
};
