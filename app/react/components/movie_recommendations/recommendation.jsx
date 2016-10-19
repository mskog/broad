import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import ImageLoader from 'react-imageloader';

class Recommendation extends React.Component {
  render() {
    var posterSrc = `/movie_posters/${this.props.ids.tmdb}`;

    return(
        <li className="col-md-3">
          <img src={posterSrc} className="img-responsive"/>
          <div className="m-t">
            Download
            Hide
          </div>
        </li>
    );
  }
}

export default Recommendation;
