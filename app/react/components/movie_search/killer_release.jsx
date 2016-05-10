import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';

import DownloadButton from './download_button';

class KillerRelease extends React.Component {
  render() {
    return(
      <div>
        <strong>{this.props.release_name}</strong>
        <br />
        {this.props.joined_attributes}
        <h4>This is a killer release</h4>
        <DownloadButton imdb_id={this.props.imdb_id} />
      </div>
    );
  }
}

export default KillerRelease;
