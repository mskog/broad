import React from "react";
import Button from "react-bootstrap/lib/Button";
import PropTypes from "prop-types";

class CollectButton extends React.Component {
  render() {
    return (
      <form
        method="post"
        action={`/tv_shows/collect?imdb_id=${this.props.imdb_id}`}
      >
        <Button type="submit" bsStyle="success" bsSize="small">
          Collect
        </Button>
      </form>
    );
  }
}

CollectButton.propTypes = {
  imdb_id: PropTypes.string.isRequired
};

export default CollectButton;
