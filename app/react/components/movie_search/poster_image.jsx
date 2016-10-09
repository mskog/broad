import React from 'react';
import LazyLoad from 'react-lazy-load';
import ImageLoader from 'react-imageloader';
import FontAwesome from 'react-fontawesome';

class PosterImage extends React.Component {
  preloader() {
    return <FontAwesome spin size='2x' name='circle-o-notch'/>;
  }

  render() {
    var imgProps = {className: 'img-responsive'}

    return(
      <LazyLoad offsetVertical={300}>
        <ImageLoader imgProps={imgProps} src={this.props.src} preloader={this.preloader} />
      </LazyLoad>
    );
  }
}

export default PosterImage;
