const mongoose = require('mongoose')
const Schema = mongoose.Schema

const cmsSchema = new Schema
    (
        {
            policyNumber: {
                type: String
            },
            patientName: {
                type: String
            },
            patientDOB: {
                type: String
            }
        },
        {
            toJSON: { virtuals: true },
            toObject: { virtuals: true }
        }
    )

module.exports = mongoose.model('CMS', cmsSchema)