import React from 'react';
import FontAwesome from 'react-fontawesome';
import MomentDate from './moment_date';

class DownloadAt extends React.Component {
  render() {
    return(
        <div>
          <FontAwesome name='cloud-download' />
          <MomentDate date={this.props.title} />
        </div>
    );
  }
}

export default DownloadAt;
