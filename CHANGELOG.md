# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [4.3.1] - 2022-07-27

### Changed

- Rework arguments in various places to support ruby 3.0 restrictions.

### Changed

- Specify major version number of ruby in Docker testing command in README


## [4.2.0] - 2022-02-23

### Changed/Fixed

- Allow update_user to handle full_name and email, and make site_role optional.


## [4.1.0] - 2022-02-17

### Changed/Fixed

- Added Users#remove_user to remove the user from the site.
- Added Users#find_by_username that returns the user with the matching
  username.
- Housekeeping, move from Travis to GA, update gems and ruby.


## [4.0.0] - 2020-11-30

### Changed/Fixed

- Changed interface to Connection#api_get_collection to properly merge a string
  query with the pagination parameters instead of overwriting the pagination
  params. This means you can't pass a Hash `query` parameter to `Jobs#list`
  anymore, but job filtering now works properly because colons in the filter
  will not be URL-encoded.
- Avoid mutating extra argument hash to endpoint methods


## [3.0.0] - 2020-11-11

### Added

- Added Jobs resource


### Changed

- Updated to API version 3.1
  - This is a breaking change for site roles: 
    https://help.tableau.com/current/api/rest_api/en-us/REST/rest_api_concepts_new_site_roles.htm
- Include full error detail in TableauError message


## [2.0.0] - 2019-08-29

- Updated to API version 2.8, compatible with Tableau Server >= 10.5
- Add `refresh` and `image_preview` methods for workbooks
- Bumped the Ruby versions in the Travis matrix build to 2.3.4, 2.2.7, and

## [1.1.2] - 2017-05-24

### Fixed

- Replaced corrupt `.gem` upload to RubyGems

## [1.1.1] - 2017-05-24 - [YANKED]

### Added

- Added Ruby 2.4.1 to the Travis matrix build

### Changed

- Bumped the Ruby versions in the Travis matrix build to 2.3.4, 2.2.7, and
  2.1.10
- Bumped the Ruby version for development to 2.4.1
- Bumped the RSpec version for development to 3.6
- Bumped the WebMock version for development to 3.0
- Updated the authors

### Fixed

- Updated `TableauApi::VERSION`

## [1.1.0] - 2017-03-02

### Added

- [#2](https://github.com/civisanalytics/tableau_api/pull/2)
  - `TableauApi::Resources::Groups` added to support API calls for
    adding/deleting/updating groups.
  - `TableauApi::Resources::Workbook#remove_permissions` added, including
    support for user and group permissions.
  - `TableauApi::Resources::Workbook#add_permissions` supports group
    permissions.
- [#6](https://github.com/civisanalytics/tableau_api/pull/6)
  Added `Users#update_user`
- [#7](https://github.com/civisanalytics/tableau_api/pull/7)
  Added `Sites#create` and `Sites#delete`

### Changed

- [#3](https://github.com/civisanalytics/tableau_api/pull/3)
  `TableauApi::Resources::Workbook#permissions` now returns existing permissions
  instead of adding new permissions. New permissions can be added with
  `TableauApi::Resources::Workbook#add_permissions`.

### Fixed

- [#4](https://github.com/civisanalytics/tableau_api/pull/4)
  Always parse/return workbook permissions as an array

## [1.0.0] - 2016-06-06

- Initial Release

[Unreleased]: https://github.com/civisanalytics/tableau_api/compare/v1.1.2...HEAD
[1.1.2]: https://github.com/civisanalytics/tableau_api/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/civisanalytics/tableau_api/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/civisanalytics/tableau_api/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/civisanalytics/tableau_api/tree/v1.0.0
