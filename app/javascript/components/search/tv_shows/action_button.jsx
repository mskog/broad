import React from "react";
import Button from "react-bootstrap/lib/Button";
import PropTypes from "prop-types";

class ActionButton extends React.Component {
  render() {
    const { method, url, text } = this.props;

    return (
      <form method={method} action={url}>
        <Button type="submit" bsStyle="success" bsSize="small">
          {text}
        </Button>
      </form>
    );
  }
}

ActionButton.propTypes = {
  method: PropTypes.string.isRequired,
  url: PropTypes.string.isRequired,
  text: PropTypes.string.isRequired
};

export default ActionButton;
