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
               <Link path={Route.post(~slug=post.slug)}>
                 post.title->React.string
               </Link>
             </div>
           )
         ->React.array}
      </div>
      <div> <Link path=Route.main> "To Main"->React.string </Link> </div>
    </div>
  </Page>;
};
