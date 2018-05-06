import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';

import AcceptableRelease from './acceptable_release';
import KillerRelease from './killer_release';
import NoAcceptableRelease from './no_acceptable_release';

class Release extends React.Component {
  render() {
    var release;
    if (this.props.has_killer_release == true){
      release = <KillerRelease {...this.props.best_release} imdb_id={this.props.imdb_id} />
    } else if (this.props.has_acceptable_release == true){
      release = <AcceptableRelease {...this.props.best_release} imdb_id={this.props.imdb_id} />
    } else {
      release = <NoAcceptableRelease imdb_id={this.props.imdb_id} />
    }

    return(
      <Row>
        <Col md={12}>
          <h3>Release information</h3>
          {release}
        </Col>
      </Row>
    );
  }
}

export default Release;
