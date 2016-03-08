import React from 'react';
import PosterImage from './poster_image';
import Title from './title';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import Panel from 'react-bootstrap/lib/Panel';

class Result extends React.Component {
  render() {
    return(
        <li>
          <Panel>
            <Row>
              <Col md={2}>
                <PosterImage src={this.props.poster} />
              </Col>
              <Col md={10}>
                <Title title={this.props.title} year={this.props.year} />
              </Col>
            </Row>
          </Panel>
        </li>
    );
  }
}

export default Result;
