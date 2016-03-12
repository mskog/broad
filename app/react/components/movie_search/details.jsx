import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';

import RtIcon from '../rt_icon';

class Details extends React.Component {
  render() {
    return(
      <Row>
        <Col md={6}>
          <RtIcon tomato_meter={this.props.tomato_meter} />
        </Col>
      </Row>
    );
  }
}

export default Details;
