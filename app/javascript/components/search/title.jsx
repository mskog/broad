import React from 'react';

class Title extends React.Component {
  render() {
    return(
      <h2>
        {this.props.title}
        <span className='small m-l-sm'>
          {this.props.year}
        </span>
      </h2>
    );
  }
}

export default Title;
