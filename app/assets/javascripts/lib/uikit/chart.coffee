angular.module 'chart-module', []

.directive 'chart', ->
  restrict: 'E'
  scope:
    data: '='
    config: '='
  link: (scope, elem)->
    drawChart = (data)->
      c3Obj =
        bindto: elem[0]
        data: scope.data

      if scope.config
        c3Obj = angular.extend c3Obj, scope.config

      c3.generate c3Obj

    scope.lineChart = false
    scope.$watch 'data', ((data)->
      if scope.lineChart
        scope.lineChart.load data
      else
        scope.lineChart = drawChart(data)
    ), true
