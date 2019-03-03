import React from 'react';
import { shallow } from 'enzyme';
import ExampleWork, { ExampleWorkBubble } from '../js/example-work';

import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
Enzyme.configure({ adapter: new Adapter() });

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
    }
];

describe("ExampleWork component", () => {
    let component = shallow(<ExampleWork work={myWork}/>)
    it("Should be a span element", () => {
        expect(component.type()).toEqual('span');
    });

    it("Should contain one child per data item", () => {
        expect(component.find("ExampleWorkBubble").length).toEqual(myWork.length);
    });

    it("Should open and close the modal window", () => {
        component.instance().openModal();
        expect(component.instance().state.modalOpen).toBe(true);
        component.instance().closeModal();
        expect(component.instance().state.modalOpen).toBe(false);
    });
});

describe("ExampleWorkBubble component", () => {
    let mockOpenModalFn = jest.fn();

    let component = shallow(<ExampleWorkBubble example={myWork[1]} 
        openModal={mockOpenModalFn} />);
    let images = component.find("img");

    it("Should contain a single IMG element", () => {
        expect(images.length).toEqual(1);
    });

    it("Should have the img src set correctly", () => {
        expect(images.prop('src')).toEqual(myWork[1].image.src);
    });

    it("Should call the openModal handler when clicked", () => {
        component.find(".section__exampleWrapper").simulate('click');
        expect(mockOpenModalFn).toHaveBeenCalled();
    });
});