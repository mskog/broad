import React from 'react';
import PosterImage from './poster_image';
import Title from './title';
import ReleaseDetails from './release_details';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import Panel from 'react-bootstrap/lib/Panel';
import Button from 'react-bootstrap/lib/Button';

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
                <Row>
                  <Col md={12}>
                    <Title title={this.props.title} year={this.props.year} />
                  </Col>
                </Row>
                <Row>
                  <Col md={8}>
                    <p>
                      {this.props.overview}
                    </p>
                  </Col>
                </Row>
                <ReleaseDetails imdb_id={this.props.imdb_id} loadDetails={this.props.loadDetails}/>
                <Row>
                  <Col md={12}>
                  </Col>
                </Row>

              </Col>
            </Row>
          </Panel>
        </li>
    );
  }
}

export default Result;
