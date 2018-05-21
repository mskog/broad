import React from "react";
import moment from "moment";
import PropTypes from "prop-types";

class MomentDate extends React.Component {
  render() {
    var time = moment(this.props.date).calendar(null, {
      sameDay: "[Today]",
      nextDay: "[Tomorrow]",
      nextWeek: "dddd",
      lastDay: "[Yesterday]",
      lastWeek: "YYYY-MM-DD",
      sameElse: "YYYY-MM-DD"
    });

    return <span>{time}</span>;
  }
}

MomentDate.propTypes = {
  date: PropTypes.object.isRequired
};

export default MomentDate;
