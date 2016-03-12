import React from 'react';
import Button from 'react-bootstrap/lib/Button';

class DownloadButton extends React.Component {
  render() {
    return(
      <form method='post' action={`/movie_downloads?query=${this.props.imdb_id}`}>
        <Button type='submit' bsStyle='success' bsSize="small">
          Download
        </Button>
      </form>
    );
  }
}

export default DownloadButton;
