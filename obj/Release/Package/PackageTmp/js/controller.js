
//mock data
var app = angular.module('main', ['ngTable', 'ngAnimate']).
controller('DemoCtrl', function ($scope) {

//    //for default true checkboxes
//    $scope.Turnout = true;
//    $scope.Races = true;

   // $scope.myDropDown.yes = true;


//    //contains the mock data
//    $scope.users = [
//            { name: "Election Day Turnout", votes: 45883, reg: 5.91 },
//            { name: "Early Vote Turnout", votes: 43, reg: 7.96 },
//            { name: "Mail Turnout", votes: 27, reg: 1.93 }
//        ];


    //default dropdown selection
    $scope.myDropDown = 'all';




//    //animation test
//    $scope.toggle = true;




















//    var initialOptions = ['1', '2', '3'];

//    $scope.options = initialOptions;
//    $scope.selectedOption = $scope.options[2]; // pick "Three" by default

//    $scope.$watch('myDropDown', function (val) {
//        if (val === '1') {
//            $scope.options = ['One', 'Three'];
//        } else {
//            $scope.options = initialOptions;
//        }
//    });



//    //filter drop down options
//    $scope.options = [
//    {
//        name: 'Show All',
//        value: '0'
//    }, {
//        name: 'GOVERNOR',
//        value: '1'
//    }, {
//        name: 'LIEUTENANT GOVERNOR',
//        value: '2'
//    }, {
//        name: 'STATE CONTROLLER',
//        value: '3'
//    }, {
//        name: 'STATE SENATE',
//        value: '4'
//    }, {
//        name: 'STATE ASSEMBLY',
//        value: '5'
//    }, {
//        name: 'COUNTY COMMISSION',
//        value: '6'
//    }, {
//        name: 'COUNTY CLERK',
//        value: '7'
//    }, {
//        name: 'COUNTY RECORDER',
//        value: '8'
//    }, {
//        name: 'PUBLIC ADMINISTRATOR',
//        value: '9'
//    }, {
//        name: 'CONSTABLE',
//        value: '10'
//    }, {
//        name: 'DISTRICT COURT JUDGE',
//        value: '11'
//    }, {
//        name: 'REGENT',
//        value: '12'
//    }, {
//        name: 'TRUSTEE',
//        value: '13'
//    }, {
//        name: 'SHERIFF',
//        value: '14'
//    }, {
//        name: 'JUSTICE OF THE PEACE',
//        value: '15'
//    }
//    ];


//    $scope.selectedOption = $scope.options[0].value;
//    













//        <option value="0">Show All</option>
//    <option value="1">GOVERNOR</option>
//    <option value="2">LIEUTENANT GOVERNOR</option>
//    <option value="3">STATE CONTROLLER</option>
//    <option value="4">STATE SENATE</option>
//    <option value="5">STATE ASSEMBLY</option>
//    <option value="6">COUNTY COMMISSION</option>
//    <option value="7">COUNTY CLERK</option>
//    <option value="8">COUNTY RECORDER</option>
//    <option value="9">PUBLIC ADMINISTRATOR</option>
//    <option value="10">CONSTABLE</option>
//    <option value="11">DISTRICT COURT JUDGE</option>
//    <option value="12">REGENT</option>
//    <option value="13">TRUSTEE</option>
//    <option value="14">SHERIFF</option>
//    <option value="15">JUSTICE OF THE PEACE</option>








































//    //Contains the filter options
//    $scope.filterOptions = {
//        stores: [

//        {id: 2, name: 'CONGRESS', rating: 1 },
//            
//        {id: 2, name: 'SENATE', rating: 1 },
//            
//        {id: 2, name: 'HOUSE', rating: 1 }



//    ]
//    };


//    //Mapped to the model to filter
//    $scope.filterItem = {
//        store: $scope.filterOptions.stores[0]
//    };




//    //Custom filter - filter based on the name selected
//    $scope.customFilter = function (data) {
//        if (data.name === $scope.filterItem.store.name) {
//            return true;
//        } 
//        else {
//            return false;
//        }
//    };
//    



//    //The data that is shown
//    $scope.data = [
//        


//    {
//    name: "DEM - REPRESENTATIVE IN CONGRESS, DIST 1",
//        price: 198,
//        rating: 1
//    },
//    {
//        name: "REP - REPRESENTATIVE IN CONGRESS, DIST 1",
//        price: 200,
//        rating: 5
//    },
//    {
//        name: "DEM - REPRESENTATIVE IN House, DIST 3",
//        price: 200,
//        rating: 2
//    },
//    {
//        name: "DEM - REPRESENTATIVE IN Senate, DIST 4",
//        price: 10,
//        rating: 3
//    },
//    {
//        name: "REP - REPRESENTATIVE IN CONGRESS, DIST 4 ",
//        price: 200,
//        rating: 3
//    }
//    


//  ];








})