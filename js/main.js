import React from 'react';
import ReactDOM from 'react-dom';
import ExampleWork from './example-work';

const myWork = [
    {
        'title': "Work Example",
        'image': {
            'desc': "example screenshot of a coding project",
            'src': "images/example1.png",
            'comment': ``
        }
    },
    {
        'title': "Dynamic Portfolio",
        'image': {
            'desc': "A serverless dynamic web portfolio",
            'src': "images/example2.png",
            'comment': `“Chemistry” by Surian Soosay is licensed under CC BY 2.0
                        https://www.flickr.com/photos/ssoosay/4097410999`
        }
    },
    {
        'title': "Work Example",
        'image': {
            'desc': "Ocelot work",
            'src': "images/example3.png",
            'comment': `“Bengal cat” by roberto shabs is licensed under CC BY 2.0
                        https://www.flickr.com/photos/37287295@N00/2540855181`
        }
    }
]

ReactDOM.render(<ExampleWork work={myWork}/>, document.getElementById('example-work'));