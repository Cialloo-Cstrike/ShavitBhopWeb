import React, { useEffect, useState } from 'react';
import LatestWrTable from '../components/LatestWrTable';
import './LatestWrPage.css';

const LatestWrPage = () => {
  const [data, setData] = useState([]);
  const [offset, setOffset] = useState(0);
  const [loading, setLoading] = useState(false);
  const PAGE_LIMIT = 10; // Number of rows per page
  const MAX_OFFSET = 100; // Maximum offset for the API

  const fetchData = async (currentOffset) => {
    setLoading(true);
    try {
      const response = await fetch(`/api/latest/wr?offset=${currentOffset}&limit=${PAGE_LIMIT}`);
      const result = await response.json();
      setData(result);
    } catch (error) {
      console.error('Failed to fetch data:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData(offset);
  }, [offset]);

  const handleFirstPage = () => setOffset(0);
  const handleLastPage = () => setOffset(MAX_OFFSET);
  const handleNext = () => setOffset((prevOffset) => Math.min(prevOffset + PAGE_LIMIT, MAX_OFFSET));
  const handlePrevious = () => setOffset((prevOffset) => Math.max(prevOffset - PAGE_LIMIT, 0));

  const currentPage = Math.ceil(offset / PAGE_LIMIT) + 1;
  const totalPages = Math.ceil((MAX_OFFSET + 1) / PAGE_LIMIT);

  return (
    <div className="LatestWrPage">
      <h1>Latest WR Statistics</h1>
      {loading ? (
        <p>Loading...</p>
      ) : (
        <LatestWrTable data={data} />
      )}
      <div className="pagination">
        <button onClick={handleFirstPage} disabled={offset === 0}>
          First Page
        </button>
        <button onClick={handlePrevious} disabled={offset === 0}>
          Previous
        </button>
        <span>
          Page {currentPage} of {totalPages}
        </span>
        <button onClick={handleNext} disabled={offset >= MAX_OFFSET}>
          Next
        </button>
        <button onClick={handleLastPage} disabled={offset >= MAX_OFFSET}>
          Last Page
        </button>
      </div>
    </div>
  );
};

export default LatestWrPage;
