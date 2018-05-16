import React from "react";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";

import ImdbIcon from "../imdb_icon";

class Details extends React.Component {
  render() {
    return (
      <Row>
        <Col md={12}>
          <Row>
            <Col md={12}>First Aired: {this.props.first_aired}</Col>
          </Row>
          <div className="pull-left m-r-sm">
            <a
              target="_blank"
              href={`http://www.imdb.com/title/${this.props.ids.imdb}`}
            >
              <ImdbIcon />
            </a>
          </div>
        </Col>
      </Row>
    );
  }
}

export default Details;
