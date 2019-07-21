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
               <TextLink path={Route.post(~slug=post.slug)}>
                 post.title->React.string
               </TextLink>
             </div>
           )
         ->React.array}
      </div>
      <div>
        <TextLink path=Route.main> "To Main"->React.string </TextLink>
      </div>
    </div>
  </Page>;
};
