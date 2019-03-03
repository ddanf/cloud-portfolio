import React from 'react';
import ReactDOM from 'react-dom';
import ExampleWork from './example-work';

const myWork = [
    {
        'title': "Work Example",
        'href': "https://example.com",
        'desc': "Laborum occaecat enim fugiat laboris officia id et aute culpa consectetur.",
        'image': {
            'desc': "example screenshot of a coding project",
            'src': "images/example1.png",
            'comment': ``
        }
    },
    {
        'title': "Dynamic Portfolio",
        'href': "https://example.com",
        'desc': "Aliquip cillum duis duis exercitation incididunt exercitation.",
        'image': {
            'desc': "A serverless dynamic web portfolio",
            'src': "images/example2.png",
            'comment': `“Chemistry” by Surian Soosay is licensed under CC BY 2.0
                        https://www.flickr.com/photos/ssoosay/4097410999`
        }
    },
    {
        'title': "Work Example",
        'href': "https://example.com",
        'desc': "Deserunt voluptate tempor ex minim amet.",
        'image': {
            'desc': "Ocelot work",
            'src': "images/example3.png",
            'comment': `“Bengal cat” by roberto shabs is licensed under CC BY 2.0
                        https://www.flickr.com/photos/37287295@N00/2540855181`
        }
    }
]

ReactDOM.render(<ExampleWork work={myWork}/>, document.getElementById('example-work'));