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
    var posterSrc = `/movie_posters/${this.props.tmdb_id}`;
    var downloaded = this.props.downloaded == true ? <span className='label label-danger'>Already downloaded</span> : ''
    return(
        <li>
          <Panel>
            <Row>
              <Col sm={3}>
                <PosterImage src={posterSrc } />
              </Col>
              <Col sm={9}>
                <Row>
                  <Col sm={12}>
                    <Title title={this.props.title} year={this.props.year} />
                  </Col>
                </Row>
                <Row>
                  <Col sm={12}>
                    <p>
                      {this.props.overview}
                    </p>
                  </Col>
                </Row>
                {downloaded}
                <ReleaseDetails imdb_id={this.props.imdb_id} loadDetails={this.props.loadDetails}/>
              </Col>
            </Row>
          </Panel>
        </li>
    );
  }
}

export default Result;
