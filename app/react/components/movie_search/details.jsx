import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';

import RtIcon from '../rt_icon';
import ImdbIcon from '../imdb_icon';

class Details extends React.Component {
  render() {
    return(
      <Row>
        <Col md={6}>
          <div className="pull-left m-r-sm">
            <a target='_blank' href={`http://www.imdb.com/title/${this.props.imdb_id}`}>
              <ImdbIcon />
            </a>
          </div>

          <RtIcon tomato_meter={this.props.tomato_meter} />
        </Col>
      </Row>
    );
  }
}

export default Details;
