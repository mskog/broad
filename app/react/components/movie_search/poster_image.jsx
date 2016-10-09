import React from 'react';
import LazyLoad from 'react-lazy-load';

// TODO Placeholder images
class PosterImage extends React.Component {
  render() {
    return(
      <LazyLoad offsetVertical={200}>
        <img className='img-responsive' src={this.props.src} />
      </LazyLoad>
    );
  }
}

export default PosterImage;
