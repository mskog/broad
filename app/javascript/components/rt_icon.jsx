import React from "react";
import PropTypes from "prop-types";

class RtIcon extends React.Component {
  icon() {
    var imageUrl = "";
    if (this.props.tomato_meter >= 60) {
      imageUrl = "/images/rt_fresh.png";
    } else {
      imageUrl = "/images/rt_rotten.png";
    }

    return (
      <img width="50" height="50" className="media-object" src={imageUrl} />
    );
  }

  render() {
    return (
      <div>
        <div className="pull-left">{this.icon()}</div>
        <div className="vertical-center p-l-xs pull-left">
          <h4>{this.props.tomato_meter}%</h4>
        </div>
      </div>
    );
  }
}

RtIcon.propTypes = {
  tomato_meter: PropTypes.number.isRequired
};

export default RtIcon;
