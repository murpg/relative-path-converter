component name='RelativePathConverter' {
	
	property name='contextPath' type='string' default='/';

	public RelativePathConverter function init(string contextPath = '.') {
		setContextPath(arguments.contextPath);

		return this;
	}

	public RelativePathConverter function setContextPath(required string contextPath) {
		variables.contextPath = ExpandPath(arguments.contextPath);

		return this;
	}
	
	public string function convert(required string absolutePath) {
		guardAgainstMissingFile(arguments.absolutePath);
		guardAgainstRelativePath(arguments.absolutePath);

		var relativePath = navigateToAbsolutePath(
			currentPath = variables.contextPath,
			absolutePath = arguments.absolutePath
		);

		return trimTrailingCharacter(character = '/', from = relativePath);
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
				return absolutePathArray[i] & '/' & navigateToAbsolutePath(
					currentPath = arguments.currentPath & '/' & absolutePathArray[i],
					absolutePath = arguments.absolutePath
				);
			}

			if (i > absolutePathArrayLength || currentPathArray[i] != absolutePathArray[i]) {
				return '../' & navigateToAbsolutePath(
					currentPath = '/' & ArrayToList(ArraySlice(currentPathArray, 1, currentPathArrayLength - 1), '/'),
					absolutePath = arguments.absolutePath
				);
			}
		}

	}

	private void function guardAgainstMissingFile(required string absolutePath) {
		if (!FileExists(ExpandPath(arguments.absolutePath))) {
			throw(
				type = 'FileDoesNotExist',
				message = 'The file #arguments.absolutePath# does not exist.'
			);
		}
		return;
	}

	private void function guardAgainstRelativePath(required string absolutePath) {
		if (ExpandPath(arguments.absolutePath) != arguments.absolutePath) {
			throw(
				type = 'AbsolutePathNeeded',
				message = 'A relative path [#arguments.absolutePath#] was passed.  An absolute path is required.'
			);
		}
		return;
	}

	private string function trimTrailingCharacter(required string character, required string from) {
		if (Right(arguments.from, 1) == arguments.character) {
			return Left(arguments.from, Len(arguments.from)-1)
		}

		return arguments.from;
	}

}