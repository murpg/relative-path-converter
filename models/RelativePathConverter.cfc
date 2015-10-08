component name='RelativePathConverter' {
	
	property name='contextPath' type='string' default='/';

	public RelativePathConverter function init(string contextPath = '.') {
		this.setContextPath(arguments.contextPath);

		return this;
	}

	public void function setContextPath(required string contextPath) {
		variables.contextPath = ExpandPath(arguments.contextPath);
	}
	
	public string function convert(required string absolutePath) {
		var relativePath = variables.navigateToAbsolutePath(
			currentPath = variables.contextPath,
			absolutePath = arguments.absolutePath
		);

		return trimTrailingCharacter(relativePath, '/');
	}


	private function navigateToAbsolutePath(
		required string currentPath,
		required string absolutePath
	) {
		if (arguments.currentPath == arguments.absolutePath) {
			return;
		}

		var currentPathArray = ListToArray(arguments.currentPath, '/');
		var absolutePathArray = ListToArray(arguments.absolutePath, '/');

		var currentPathArrayLength = ArrayLen(currentPathArray);
		var absolutePathArrayLength = ArrayLen(absolutePathArray);
		var maxArrayLength = Max(currentPathArrayLength, absolutePathArrayLength);

		for (var i = 1; i <= maxArrayLength; i++) {
			if (i > currentPathArrayLength) {
				return absolutePathArray[i] & '/' & variables.navigateToAbsolutePath(
					currentPath = arguments.currentPath & '/' & absolutePathArray[i],
					absolutePath = arguments.absolutePath
				);
			}

			if (i > absolutePathArrayLength || currentPathArray[i] != absolutePathArray[i]) {
				return '../' & variables.navigateToAbsolutePath(
					currentPath = '/' & ArrayToList(ArraySlice(currentPathArray, 1, currentPathArrayLength - 1), '/'),
					absolutePath = arguments.absolutePath
				);
			}
		}

	}

	private string function trimTrailingCharacter(required string str, required string char) {
		if (Right(arguments.str, 1) == arguments.char) {
			return Left(arguments.str, Len(arguments.str)-1)
		}

		return arguments.str;
	}

}