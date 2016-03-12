import React from 'react';
import Button from 'react-bootstrap/lib/Button';

class WaitlistButton extends React.Component {
  render() {
    return(
      <form className="m-t-sm" method='post' action={`/movie_waitlists?query=${this.props.imdb_id}`}>
        <Button type='submit' bsStyle='success' bsSize="small">
          Add to Waitlist
        </Button>
      </form>
    );
  }
}

export default WaitlistButton;
