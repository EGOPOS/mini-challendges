class_name OneCall extends RefCounted

static var called: Array

static func callable(callable: Callable):
	if not called.has(callable):
		callable.call()
		called.append(callable)

static func reset_callable(callable: Callable):
	if called.has(callable):
		called.erase(callable)
