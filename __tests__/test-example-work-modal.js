import React from 'react';
import { shallow } from 'enzyme';
import ExampleWorkModal from '../js/e-work-modal';

import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
Enzyme.configure({ adapter: new Adapter() });

const myWork = {
        'title': "Work Example",
        'href': "https://example.com",
        'desc': "Laborum occaecat enim fugiat laboris officia id et aute culpa consectetur.",
        'image': {
            'desc': "example screenshot of a coding project",
            'src': "images/example1.png",
            'comment': ``
        }
    };

describe("ExampleWorkModal component", () => {
    let mockCloseModalFn = jest.fn();

    let component = shallow(<ExampleWorkModal example = {myWork} open={false} />);
    let openComponent = shallow(<ExampleWorkModal example = {myWork} open={true} 
        closeModal={mockCloseModalFn }/>);

    let anchors = component.find("a");

    it("Should contain a single 'a' element", () => {
        expect(anchors.length).toEqual(1);
    });

    it("Should link to our project", () => {
        expect(anchors.prop('href')).toEqual(myWork.href)
    });

    it("Should have the modal class set correctly", () => {
        expect(component.find(".background--skyBlue").hasClass("modal--closed")).toBe(true);
        expect(openComponent.find(".background--skyBlue").hasClass("modal--open")).toBe(true);
    });

    it("Should call closeModal handler when clicked", () => {
        openComponent.find(".modal__closeButton").simulate('click');
        expect(mockCloseModalFn).toHaveBeenCalled();
    })
});
