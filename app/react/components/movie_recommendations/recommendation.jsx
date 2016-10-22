import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import ImageLoader from 'react-imageloader';
import FontAwesome from 'react-fontawesome';
import {imagePath} from 'rwr-view-helpers';
import PosterImage from '../movie_search/poster_image';

class Recommendation extends React.Component {

  handleDownload(event) {
    this.props.onDownload(this.props.id);
  }

  render() {
    var posterSrc = `/movie_posters/${this.props.tmdb_id}`;


    return(
        <li className="col-md-3">
        <PosterImage src={posterSrc} />
        <div className="m-t">
          <span onClick={this.handleDownload.bind(this)}>Download</span>
          Hide
        </div>
        </li>
    );
  }
}

export default Recommendation;
