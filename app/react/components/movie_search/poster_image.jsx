import React from 'react';

// TODO Placeholder images
class PosterImage extends React.Component {
  render() {
    return(
      <img className='img-responsive' src={this.props.src} />
    );
  }
}

export default PosterImage;
