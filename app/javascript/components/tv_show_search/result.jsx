import React from "react";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";
import Panel from "react-bootstrap/lib/Panel";
import Button from "react-bootstrap/lib/Button";
import Title from "./title";
import PosterImage from "../poster_image";
import ReleaseDetails from "./release_details";

class Result extends React.Component {
  render() {
    console.log(this.props);
    var posterSrc = `/posters/${this.props.tmdb_id}?type=tv_show`;
    var downloaded =
      this.props.downloaded == true ? (
        <span className="label label-danger">Already downloaded</span>
      ) : (
        ""
      );
    return (
      <li>
        <Panel>
          <Row>
            <Col sm={3}>
              <PosterImage src={posterSrc} />
            </Col>
            <Col sm={9}>
              <Row>
                <Col sm={12}>
                  <Title title={this.props.title} year={this.props.year} />
                </Col>
              </Row>
              <Row>
                <Col sm={12}>
                  <p>{this.props.overview}</p>
                </Col>
              </Row>
              {downloaded}
              <ReleaseDetails
                imdb_id={this.props.imdb_id}
                loadDetails={this.props.loadDetails}
              />
            </Col>
          </Row>
        </Panel>
      </li>
    );
  }
}

export default Result;
