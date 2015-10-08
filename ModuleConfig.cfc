component name='ModuleConfig' {

	// Module Properties
	this.title 				= 'Relative Path Converter';
	this.author 			= 'Eric Peterson';
	this.webURL 			= 'http://www.coldbox.org/forgebox/view/relative-path-converter';
	this.description 		= 'Convert an absolute path to a relative path given a context directory.';
	this.version			= '1.0.0';
	this.modelNamespace		= 'RelativePathConverter';

	function configure(){		
		binder.map('RelativePathConverter').to('#moduleMapping#.models.RelativePathConverter')
	}

}