#include <pybind11/pybind11.h>
namespace py = pybind11;
using namespace pybind11::literals;

int add(int i, int j) {
    return i + j;
}

py::dict my_dict(){
  py::dict p;
	py::dict x;
	x["x"] = 3;
	x["y"] = 7;
	p["first"] = x;
	p["second"] = 123;
	return p;
}

PYBIND11_MODULE(example, m) {
    m.doc() = "pybind11 example plugin"; // optional module docstring

    m.def("add", &add, "A function that adds two numbers");
		m.def("get_dict", []() { return py::dict("key"_a="value"); });
    m.def("print_dict", [](const py::dict &dict) {
        for (auto item : dict)
            py::print("key: {}, value={}"_s.format(item.first, item.second));
    });
		m.def("my_dict", &my_dict, "my test dict");
}
