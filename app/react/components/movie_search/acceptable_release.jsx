import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';

import DownloadButton from './download_button';
import WaitlistButton from './waitlist_button';

class AcceptableRelease extends React.Component {
  render() {
    return(
      <div>
        <strong>{this.props.release_name}</strong>
        <br />
        {this.props.joined_attributes}
        <h4>This is an acceptable release</h4>
        <DownloadButton imdb_id={this.props.imdb_id} />
        <WaitlistButton imdb_id={this.props.imdb_id} />
      </div>
    );
  }
}

export default AcceptableRelease;
