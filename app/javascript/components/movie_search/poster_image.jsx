import React from "react";
import LazyLoad from "react-lazy-load";
import ImageLoader from "react-imageloader";
import FontAwesome from "react-fontawesome";
import { imagePath } from "rwr-view-helpers";

// TODO Move this up a level
class PosterImage extends React.Component {
  preloader() {
    return (
      <img
        className="img-responsive"
        src={imagePath("placeholder_movie_poster.jpg")}
      />
    );
  }

  render() {
    var imgProps = { className: "img-responsive pull-left" };

    return (
      <LazyLoad offsetVertical={300}>
        <img src={this.props.src} {...imgProps} />
      </LazyLoad>
    );
  }
}

export default PosterImage;
