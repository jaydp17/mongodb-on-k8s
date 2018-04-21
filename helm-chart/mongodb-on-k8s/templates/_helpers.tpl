{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "web-app.name" -}}
web-app
{{- end -}}

{{- define "mongo.name" -}}
mongodb
{{- end -}}

{{- define "imagePullPolicy" }}
{{- if .Values.app.imageTag -}}
IfNotPresent
{{- else -}}
Always  
{{- end -}}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongodb-on-k8s.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
