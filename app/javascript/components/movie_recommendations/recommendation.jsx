import React from "react";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";
import ImageLoader from "react-imageloader";
import FontAwesome from "react-fontawesome";
import { imagePath } from "rwr-view-helpers";
import PosterImage from "../movie_search/poster_image";

import Details from "../movie_search/details";

class Recommendation extends React.Component {
  handleDownload(event) {
    this.props.onDownload(this.props.id);
  }

  handleHide(event) {
    this.props.onHide(this.props.id);
  }

  render() {
    var posterSrc = `/movie_posters/${this.props.tmdb_id}`;
    var imdbLink = `http://www.imdb.com/title/${this.props.imdb_id}`;

    return (
      <li className="col-md-3">
        <a target="_blank" href={imdbLink}>
          <PosterImage src={posterSrc} />
        </a>
        <Row>
          <Col md={12}>
            <Details {...this.props} />
          </Col>
        </Row>
        <Row>
          <Col md={12}>
            <div className="m-t">
              <a
                className="btn btn-sm btn-success"
                onClick={this.handleDownload.bind(this)}
              >
                Download
              </a>
              <a
                className="btn btn-sm btn-danger m-l"
                onClick={this.handleHide.bind(this)}
              >
                Hide
              </a>
            </div>
          </Col>
        </Row>
      </li>
    );
  }
}

export default Recommendation;
