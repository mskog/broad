import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import ImageLoader from 'react-imageloader';
import FontAwesome from 'react-fontawesome';
import {imagePath} from 'rwr-view-helpers';

class Recommendation extends React.Component {
  preloader() {
    return <img className='img-responsive' src={imagePath('placeholder_movie_poster.jpg')} />;
  }

  render() {
    var posterSrc = `/movie_posters/${this.props.tmdb_id}`;
    var imgProps = {className: 'img-responsive'}

    return(
        <li className="col-md-3">
          <ImageLoader imgProps={imgProps} src={posterSrc} preloader={this.preloader} />
          <div className="m-t">
            Download
            Hide
          </div>
        </li>
    );
  }
}

export default Recommendation;
