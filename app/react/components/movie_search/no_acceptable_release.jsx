import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';

import WaitlistButton from './waitlist_button';

class NoAcceptableRelease extends React.Component {
  render() {
    return(
      <div>
        <h4>No acceptable releases found</h4>
        <WaitlistButton imdb_id={this.props.imdb_id} />
      </div>
    );
  }
}

export default NoAcceptableRelease;
