component name='RelativePathConverter' extends='testbox.system.BaseSpec' {
	
	function run() {
		describe('Converting absolute paths to relative paths', function() {

			var CUT = '';

			beforeEach(function() {
				CUT = new models.RelativePathConverter();
			});

			it('returns a relative path given an absolute path and a context directory', function() {
				var absolutePath = ExpandPath('/tests/stubs/testFile.cfm');

				var relativePath = CUT.convert(absolutePath);

				expect(relativePath).toBe('stubs/testFile.cfm');
			});

			it('converts higher up directories correctly', function() {
				CUT.setContextPath('./stubs/testFolder');
				var absolutePath = ExpandPath('/tests/stubs/testFile.cfm');

				var relativePath = CUT.convert(absolutePath);

				expect(relativePath).toBe('../testFile.cfm');
			});

			it('converts complex paths as well', function() {
				CUT.setContextPath('./stubs/testFolder/testSubFolder');
				var absolutePath = ExpandPath('/tests/stubs/anotherTestFolder/anotherTestSubFolder/anotherTestFile.cfm');

				var relativePath = CUT.convert(absolutePath);

				expect(relativePath).toBe('../../anotherTestFolder/anotherTestSubFolder/anotherTestFile.cfm');
			});

			it('throws an exception if the absolute path doesn''t exist', function() {
				var absolutePath = '/some/path/that/does/not/exist.cfm';

				expect(function() { CUT.convert(absolutePath); }).toThrow(type = 'FileDoesNotExist');
			});

			it('throws an exception if a relative path is given instead of an absolute path', function() {
				var absolutePath = 'stubs/testFile.cfm';

				expect(function() { CUT.convert(absolutePath); }).toThrow(type = 'AbsolutePathNeeded');
			});

			xit('converts correctly across different drives', function() {
				fail('Test not implemented yet.');
			});

		});
	}

}