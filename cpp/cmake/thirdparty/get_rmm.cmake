#=============================================================================
# Copyright (c) 2021, NVIDIA CORPORATION.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#=============================================================================

function(find_and_configure_rmm VERSION)

    if(TARGET rmm::rmm)
        return()
    endif()

    if(${VERSION} MATCHES [=[([0-9]+)\.([0-9]+)\.([0-9]+)]=])
        set(MAJOR_AND_MINOR "${CMAKE_MATCH_1}.${CMAKE_MATCH_2}")
    else()
        set(MAJOR_AND_MINOR "${VERSION}")
    endif()

    rapids_cpm_find(rmm ${VERSION}
        GLOBAL_TARGETS      rmm::rmm
        BUILD_EXPORT_SET    rapids_triton-exports
        INSTALL_EXPORT_SET  rapids_triton-exports
        CPM_ARGS
            GIT_REPOSITORY  https://github.com/rapidsai/rmm.git
            GIT_TAG         23bbe745af1d988224b5498f7b8e3fe3720532d4
            GIT_SHALLOW     FALSE
            OPTIONS         "BUILD_TESTS OFF"
                            "BUILD_BENCHMARKS OFF"
                            "CUDA_STATIC_RUNTIME ${CUDA_STATIC_RUNTIME}"
                            "DISABLE_DEPRECATION_WARNING ${DISABLE_DEPRECATION_WARNING}"
    )

endfunction()

set(RAPIDS_TRITON_MIN_VERSION_rmm "${RAPIDS_TRITON_VERSION_MAJOR}.${RAPIDS_TRITON_VERSION_MINOR}.00")

find_and_configure_rmm(${RAPIDS_TRITON_MIN_VERSION_rmm})