import React from "react";
import Button from "react-bootstrap/lib/Button";
import PropTypes from "prop-types";

class SampleButton extends React.Component {
  render() {
    return (
      <form
        method="post"
        action={`/tv_shows/sample?imdb_id=${this.props.imdb_id}`}
      >
        <Button type="submit" bsStyle="success" bsSize="small">
          Sample
        </Button>
      </form>
    );
  }
}

SampleButton.propTypes = {
  imdb_id: PropTypes.string.isRequired
};

export default SampleButton;
