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

			xit('converts correctly across different drives', function() {
				fail('Test not implemented yet.');
			});

		});
	}

}