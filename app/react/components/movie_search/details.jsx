import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';

class Details extends React.Component {
  render() {
    return(
      <Row>
        <Col md={6}>
          RT: {this.props.tomato_meter}%
        </Col>

      </Row>
    );
  }
}

export default Details;
